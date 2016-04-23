--Galaxy-Eyes Full Armor Photon Dragon
function c13700016.initial_effect(c)
--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,8),3,c13700016.ovfilter,aux.Stringid(38495396,1),3,c13700016.xyzop)
	c:EnableReviveLimit()
	--Attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13700016,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c13700016.con)
	e1:SetTarget(c13700016.destg)
	e1:SetOperation(c13700016.desop)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13700016,1))
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c13700016.cost)
	e2:SetTarget(c13700016.cttg)
	e2:SetOperation(c13700016.ctop)
	c:RegisterEffect(e2)
end
--Xyz Summon
function c13700016.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x107b) and c:GetCode()~=13700016 and c:IsType(TYPE_XYZ)
end

function c13700016.con(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():IsType(TYPE_XYZ) and e:GetHandler():GetEquipGroup():IsExists(Card.IsAbleToGraveAsCost,1,nil)
end
function c13700016.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c13700016.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		--local eqg=c:GetEquipGroup()
		local eqg=e:GetHandler():GetEquipGroup():FilterSelect(tp,Card.IsAbleToGraveAsCost,1,2,nil)
		if eqg:GetCount()>0 then
			Duel.Overlay(c,eqg)
		end
	end
end

function c13700016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c13700016.spfilter(c,e,tp)
	return c:IsDestructable() and c:IsFaceup()
end
function c13700016.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) and c13700016.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13700016.spfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c13700016.spfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,1,0,0)
end
function c13700016.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if tc1:IsRelateToEffect(e) then
		Duel.Destroy(tc1,REASON_EFFECT)
	end
end
