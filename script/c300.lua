--Deck Masters Basic Effects
--Scripted by edo9300
function c300.initial_effect(c)
	if not c300.global_check then
		c300.global_check=true
		--register
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PREDRAW)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCondition(c300.con)
		e1:SetOperation(c300.op)
		Duel.RegisterEffect(e1,0)
		--Pass ability Material
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_BE_MATERIAL)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
		e2:SetTarget(c300.target)
		Duel.RegisterEffect(e2,0)
		--Pass Ability on destroyed
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_LEAVE_FIELD)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e3:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
		e3:SetTarget(c300.target2)
		Duel.RegisterEffect(e3,0)
		--Lose
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e4:SetCode(EVENT_PHASE+PHASE_DRAW)
		e4:SetCountLimit(1)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e4:SetOperation(c300.loseop2)
		Duel.RegisterEffect(e4,0)
		local e5=e4:Clone()
		e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
		Duel.RegisterEffect(e5,0)
		local e6=e4:Clone()
		e6:SetCode(EVENT_PHASE_START+PHASE_BATTLE_START)
		Duel.RegisterEffect(e6,0)
		local e7=e4:Clone()
		e7:SetCode(EVENT_PHASE+PHASE_BATTLE)
		Duel.RegisterEffect(e7,0)
		local e8=e4:Clone()
		e8:SetCode(EVENT_PHASE_START+PHASE_END)
		Duel.RegisterEffect(e8,0)
		local e9=e4:Clone()
		e9:SetCode(EVENT_PHASE+PHASE_END)
		Duel.RegisterEffect(e9,0)
		--Revive Limit
		local e10=Effect.CreateEffect(c)
		e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e10:SetCode(EVENT_ADJUST)
		e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e10:SetTargetRange(LOCATION_EXTRA,LOCATION_EXTRA)
		e10:SetCondition(c300.rvcon)
		e10:SetOperation(c300.rvop)
		Duel.RegisterEffect(e10,0)
		--description
		local e11=Effect.CreateEffect(c)
		e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e11:SetCode(EVENT_ADJUST)
		e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e11:SetCondition(c300.dcon)
		e11:SetOperation(c300.dop)
		Duel.RegisterEffect(e11,0)
	end
end
function c300.dcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(function(c)return c:GetFlagEffect(300)>0 and not c:IsHasEffect(300) end,tp,0xff,0xff,1,nil)
end
function c300.dop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(function(c)return c:GetFlagEffect(300)>0 and not c:IsHasEffect(300) end,tp,0xff,0xff,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(51100567,14))
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(300)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1,true)
			tc=g:GetNext()
		end
	end
end
function c300.con(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()==1
end
function c300.accon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)>0
end
function c300.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(function(c) return c.dm end,tp,0xff,0xff,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			if tc:GetFlagEffect(300+3)==0 then
				--Remove Pendulum
				local e1=Effect.CreateEffect(tc)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_REMOVE_TYPE)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
				e1:SetValue(TYPE_PENDULUM)
				e1:SetRange(0Xff)
				tc:RegisterEffect(e1)
				--Cannot to Extra
				local e2=Effect.CreateEffect(tc)
				e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_CANNOT_TO_DECK)
				e2:SetCondition(c300.recon)
				tc:RegisterEffect(e2)
				tc:RegisterFlagEffect(300+3,RESET_PHASE+PHASE_DRAW,0,1)
			end
			tc=g:GetNext()
		end
		if Duel.GetMatchingGroupCount(function(c) return c.dm and not c.dm_no_activable and c:GetFlagEffect(300+4)==0 end,tp,0xff,0,nil)>0 and Duel.GetMatchingGroupCount(function(c) return c.dm and not c.dm_no_activable and c:GetFlagEffect(300+4)==0 end,tp,0,0xff,nil)>0 then
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(51100570,1))
			sel1=Duel.SelectOption(tp,aux.Stringid(51100570,2),aux.Stringid(51100570,3),aux.Stringid(51100570,4))
			Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(51100570,1))
			sel2=Duel.SelectOption(1-tp,aux.Stringid(51100570,2),aux.Stringid(51100570,3),aux.Stringid(51100570,4))
			c=0
			if sel1==sel2 then
				b=1
				if sel1==1 then
					Duel.RegisterFlagEffect(tp,300+4,0,0,1)
					c=1
				end
				if sel1==2 then
					Duel.RegisterFlagEffect(tp,300+4,0,0,1)
					c=2
				end
			else
				b=0
			end
			local aaa=Group.CreateGroup()
			if b==1 then
				if c>0 then
					local size=tableDm_size
					while size>0 do
						local token=Duel.CreateToken(tp,tableDm[size])
						Duel.SendtoGrave(token,nil,REASON_RULE)
						aaa:AddCard(token)
						size=size-1
					end
				end
				if c>0 then
					if c==1 then
						Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(51100570,5))
						tcc1=aaa:Select(tp,1,1,nil):GetFirst()
					end
					Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(51100570,5))
					tcc2=aaa:Select(1-tp,1,1,nil):GetFirst()
				end
				Duel.SendtoDeck(aaa,nil,-2,REASON_RULE)
				for a=0,1 do
					local g1=Duel.GetMatchingGroup(function(c) return c.dm and not c.dm_no_activable and c:GetFlagEffect(300+4)==0 end,a-tp,0xff,0,nil)
					if g1:GetCount()>1 then 
						Duel.Hint(HINT_SELECTMSG,a-tp,aux.Stringid(51100567,0))
						tc=g1:Select(a-tp,1,1,nil):GetFirst()
					else
						tc=g1:GetFirst()
					end
					local g3=Group.FromCards(tc)
					if a==0 and tcc1 then
						local tc1=Duel.CreateToken(tp,tcc1:GetOriginalCode())
						tc1:RegisterFlagEffect(300+2,0,0,1)
						g3:AddCard(tc1)
						--Lose
						local e1=Effect.CreateEffect(e:GetHandler())
						e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
						e1:SetCode(EVENT_PREDRAW)
						e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
						e1:SetLabel(tcc1:GetOriginalCode())
						e1:SetOwnerPlayer(tp)
						e1:SetLabelObject(tcc1)
						e1:SetCondition(c300.con2)
						e1:SetOperation(c300.op1)
						Duel.RegisterEffect(e1,tp)
					end
					if a==1 and tcc2 then
						local tc2=Duel.CreateToken(1-tp,tcc2:GetOriginalCode())
						tc2:RegisterFlagEffect(300+2,0,0,1)
						g3:AddCard(tc2)
						--Lose
						local e1=Effect.CreateEffect(e:GetHandler())
						e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
						e1:SetCode(EVENT_PREDRAW)
						e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
						e1:SetLabel(tcc2:GetOriginalCode())
						e1:SetOwnerPlayer(tp)
						e1:SetLabelObject(tcc2)
						e1:SetCondition(c300.con1)
						e1:SetOperation(c300.op1)
						Duel.RegisterEffect(e1,1-tp)
					end
					local tc=g3:GetFirst()
					while tc do
						tc:RegisterFlagEffect(300,0,0,1)
						if not tc.dm_custom_activate then
							--Activate
							local e1=Effect.CreateEffect(tc)
							e1:SetType(EFFECT_TYPE_ACTIVATE)
							e1:SetCode(EVENT_FREE_CHAIN)
							e1:SetReset(RESET_CHAIN)
							tc:RegisterEffect(e1)
						end
						local tc1=Duel.GetFieldCard(a-tp,LOCATION_SZONE,6)
						local tc2=Duel.GetFieldCard(a-tp,LOCATION_SZONE,7)
						if tc1==nil or tc2==nil then
							Duel.MoveToField(tc,a-tp,a-tp,LOCATION_SZONE,POS_FACEUP,true)
							local tpe=tc:GetType()
							local te=tc:GetActivateEffect()
							local tg=te:GetTarget()
							local co=te:GetCost()
							local op=te:GetOperation()
							e:SetCategory(te:GetCategory())
							e:SetProperty(te:GetProperty())
							Duel.ClearTargetCard()
							Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
							tc:CreateEffectRelation(te)
							if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
							if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
							Duel.BreakEffect()
							if op then op(te,tp,eg,ep,ev,re,r,rp) end
							tc:ReleaseEffectRelation(te)
							if not tc.dm_custom then
								if not tc.dm_no_spsummon then
								--spsummon
								local e1=Effect.CreateEffect(tc)
								e1:SetDescription(aux.Stringid(51100567,1))
								e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
								e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
								e1:SetType(EFFECT_TYPE_IGNITION)
								e1:SetRange(LOCATION_PZONE)
								e1:SetTarget(c300.sptg)
								e1:SetOperation(c300.spop)
								tc:RegisterEffect(e1)
								end
								if not tc.dm_no_splimit then
									--splimit
									local e2=Effect.CreateEffect(tc)
									e2:SetType(EFFECT_TYPE_FIELD)
									e2:SetRange(LOCATION_PZONE)
									e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
									e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
									e2:SetTargetRange(1,0)
									e2:SetTarget(c300.splimit)
									tc:RegisterEffect(e2)
								end
								if not tc.dm_no_immune then
									--Immune
									local e3=Effect.CreateEffect(tc)
									e3:SetType(EFFECT_TYPE_SINGLE)
									e3:SetCode(EFFECT_IMMUNE_EFFECT)
									e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
									e3:SetRange(LOCATION_PZONE)
									e3:SetValue(1)
									tc:RegisterEffect(e3)
								end
							end
						end
						if tc:GetPreviousLocation()==LOCATION_HAND then
							Duel.Draw(a-tp,1,REASON_RULE)
						end
						tc=g3:GetNext()
					end
				end
			else
				Duel.RegisterFlagEffect(tp,300+2,0,0,1)
				Duel.RegisterFlagEffect(1-tp,300+2,0,0,1)
				local g=Duel.GetMatchingGroup(function(c)return c.dm_replace_original end,tp,0xff,0xff,nil)
				if g:GetCount()>0 then
					local tc=g:GetFirst()
					while tc do
						local code=tc:GetCode()
						local loc=tc:GetLocation()
						Duel.SendtoDeck(tc,nil,-2,REASON_RULE)
						local token=Duel.CreateToken(tp,code)
						if loc==LOCATION_DECK then
							Duel.SendtoDeck(token,tc:GetControler(),2,REASON_RULE)
						elseif loc==LOCATION_HAND then
							Duel.SendtoHand(token,tc:GetControler(),2,REASON_RULE)
						end
						tc=g:GetNext()
					end
				end
			end
		else
			Duel.RegisterFlagEffect(tp,300+2,0,0,1)
			Duel.RegisterFlagEffect(1-tp,300+2,0,0,1)
			local g=Duel.GetMatchingGroup(function(c)return c.dm_replace_original end,tp,0xff,0xff,nil)
			if g:GetCount()>0 then
				local tc=g:GetFirst()
				while tc do
					local code=tc:GetCode()
					local loc=tc:GetLocation()
					Duel.SendtoDeck(tc,nil,-2,REASON_RULE)
					local token=Duel.CreateToken(tp,code)
					if loc==LOCATION_DECK then
						Duel.SendtoDeck(token,tc:GetControler(),2,REASON_RULE)
					elseif loc==LOCATION_HAND then
						Duel.SendtoHand(token,tc:GetControler(),2,REASON_RULE)
					end
					tc=g:GetNext()
				end
			end
		end
	Duel.RegisterFlagEffect(tp,300+3,0,0,1)
	end
end
function c300.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==e:GetOwnerPlayer() and Duel.GetFlagEffect(e:GetOwnerPlayer(),300+3)==0
end
function c300.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==e:GetOwnerPlayer() and Duel.GetFlagEffect(e:GetOwnerPlayer(),300+3)==1
end
function c300.op1(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetLabel()
	local tc=e:GetLabelObject()
	local tp=e:GetOwnerPlayer()
		Duel.RegisterFlagEffect(tp,300+3,0,0,1)
		local g=Duel.GetMatchingGroup(c300.dmfilter,tp,LOCATION_EXTRA+LOCATION_DECK+LOCATION_HAND,0,nil,code)		
		if g:GetCount()>0 then
			Duel.SendtoDeck(g:GetFirst(),tp,-2,REASON_RULE)
			if g:GetFirst():GetPreviousLocation()==LOCATION_HAND then
				Duel.Draw(tp,1,REASON_RULE)
			end
		else
			Duel.Win(1-tp,0x56)
		end
end
function c300.dmfilter(c,code)
	return c:GetOriginalCode()==code and c:GetFlagEffect(300+2)==0
end
function c300.recon(e)
	local c=e:GetHandler()
	return c:GetDestination()==LOCATION_GRAVE and c:IsLocation(LOCATION_ONFIELD)
end
function c300.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c300.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c300.abcon(c)
	if c.dm_custom_pass_ability then return c.dm_custom_pass_ability
	else
	return c:GetFlagEffect(300)>0 and r~=REASON_SUMMON end
end
function c300.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c300.abcon,1,nil,tp) end
	local g=eg:Filter(c300.abcon,nil,tp)
	if g:GetCount()>0 then
	local tc=g:GetFirst()
	while tc do
	local rc=tc:GetReasonCard()
	rc:RegisterFlagEffect(300,0,0,1)
	tc:ResetFlagEffect(300)
	tc=g:GetNext()
	end
	end
end
function c300.abcon2(c)
	if c.dm_custom_lose then return c.dm_custom_lose
	else
	return c:GetFlagEffect(300)>0 and r~=1048650
	end
end
function c300.target2(e,tp,eg,ep,ev,re,r,rp)
	if chk==0 then return eg:IsExists(c300.abcon2,1,nil,tp) end
	local g=eg:Filter(c300.abcon2,nil,tp)
	if g:GetCount()>0 then
	local tc=g:GetFirst()
	while tc do
	tc:ResetFlagEffect(300)
	Duel.ResetFlagEffect(tc:GetControler(),300+2)
	if not tc:IsReason(REASON_DESTROY) then
	Duel.RegisterFlagEffect(tc:GetControler(),300+2,0,0,1)
	end
	if Duel.GetMatchingGroupCount(c300.fil2,tc:GetControler(),0xff,0,nil)==0 then
	local ph=Duel.GetCurrentPhase()
	if ph>0x08 and ph<0x80 then ph=0x80 end
	--New dm on summon
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e1:SetLabel(tc:GetControler())
	e1:SetOperation(c300.checkop)
	e1:SetReset(RESET_PHASE+ph)
	Duel.RegisterEffect(e1,tc:GetControler())
	Duel.RegisterFlagEffect(tc:GetControler(),300+1,0,0,1)
	end
	tc=g:GetNext()
	end
end
end
function c300.splimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c300.filterdm(c,tp)
	return c:IsType(TYPE_MONSTER) and c:GetControler()==tp
end
function c300.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetLabel()
	if Duel.GetFlagEffect(tp,300+1)~=0 and Duel.GetMatchingGroupCount(c300.fil2,tp,0xff,0,nil)==0 then
	local g=eg:Filter(c300.filterdm,nil,tp)
	if g:GetCount()>0 then
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(300,0,0,1)
		tc=g:GetNext()
	end
	Duel.ResetFlagEffect(tp,300+1)
	if Duel.GetFlagEffect(tp,300+2) then
		Duel.ResetFlagEffect(tp,300+2)
	end
	end
	end
end
function c300.fil2(c)
  return c:GetFlagEffect(300)>0
end
function c300.loseop2(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_DM=0x56
	local g1=Duel.GetMatchingGroupCount(c300.fil2,tp,0xff,0,nil)
	local g2=Duel.GetMatchingGroupCount(c300.fil2,tp,0,0xff,nil)
	local f1=Duel.GetFlagEffect(tp,300+2)
	local f2=Duel.GetFlagEffect(1-tp,300+2)
	if g1==0 and g2>0 and f1==0 then
	Duel.Win(1-tp,WIN_REASON_DM)
	elseif g1==0 and g2==0 and f2==0 and f1==0  then
	Duel.Win(PLAYER_NONE,WIN_REASON_DM)
	elseif g1>0 and g2==0 and f2==0 then
	Duel.Win(tp,WIN_REASON_DM)	
	end
end
function c300.rvcon(tp)
	return Duel.GetFlagEffect(tp,300+3)>0
end
function c300.rvfil(c)
	return c.dm_revive_limit and c:GetFlagEffect(300+4)>0
end
function c300.rvop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c300.rvfil,tp,LOCATION_EXTRA,LOCATION_EXTRA,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			tc:EnableReviveLimit()
			tc:RegisterFlagEffect(300+4,0,0,1)
			tc=g:GetNext()
		end
	end
end
tableDm = {
51100567,
51100570,
511000559,
511000560,
511000562,
511000563,
511000564,
511000565,
511000566,
511000568,
511000569,
511000571,
511000572,
511000573,
511000574,
511000575,
511000590
} 
tableDm_size=17