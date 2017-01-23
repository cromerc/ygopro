--Fruit of the Dead
function c511002107.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002107.target)
	e1:SetOperation(c511002107.activate)
	c:RegisterEffect(e1)
	if not c511002107.global_check then
		c511002107.global_check=true
		c511002107[0]=0
		--register
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(511001265)
		ge1:SetOperation(c511002107.regop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002107.clear)
		Duel.RegisterEffect(ge2,0)
		--register2
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetOperation(c511002107.operation)
		Duel.RegisterEffect(e2,0)
	end
end
function c511002107.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:GetFlagEffect(511001265)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511002107.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511001265,RESET_EVENT+0x1fe0000,0,1) 	
		end	
		tc=g:GetNext()
	end		
end
function c511002107.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	local val=0
	if e:GetLabel()>c:GetAttack() then
		val=e:GetLabel()-c:GetAttack()
	else
		val=c:GetAttack()-e:GetLabel()
	end
	Duel.RaiseEvent(c,511001265,re,REASON_EFFECT,rp,tp,val)
	e:SetLabel(c:GetAttack())
end
function c511002107.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c511002107[0]>0 end
	local ct=c511002107[0]
	local t={}
	for i=1,ct do
		t[i]=c511002107[i]
	end
	local dam=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,dam)
end
function c511002107.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c511002107.regop(e,tp,eg,ep,ev,re,r,rp)
	c511002107[0]=c511002107[0]+1
	c511002107[c511002107[0]]=ev
end
function c511002107.clear(e,tp,eg,ep,ev,re,r,rp)
	local ct=c511002107[0]
	if ct>0 then
		local i=1
		while c511002107[i]~=nil do
			c511002107[i]=nil
			i=i+1
		end
		c511002107[0]=0
	end
end
